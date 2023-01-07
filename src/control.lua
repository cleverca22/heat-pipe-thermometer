function find_and_bind_heatpipe(entity)
  global.temp_sensors[entity.unit_number] = { thermometer = entity }
  log(entity.position)
  local pos = entity.position
  local south = { x=entity.position.x, y = entity.position.y + 1 }
  local surface = entity.surface
  --local results = surface.find_entities({{pos.x - 1, pos.y - 1},{pos.x + 1, pos.y + 1}})
  local results = surface.find_entities_filtered{ area = {{pos.x - 1, pos.y - 1},{pos.x + 1, pos.y + 1}}, type = "heat-pipe", limit=1 }
  if #results > 0 then
    global.temp_sensors[entity.unit_number].heatpipe = results[1]
  end
end

function on_ent_create(event)
  local ent = event.created_entity
  if ent.name == "heat-pipe-thermometer" then
    log(game.table_to_json(event))
    log(ent.position)
    global.temp_sensors = global.temp_sensors or {}
    find_and_bind_heatpipe(ent)
  end
end

script.on_event(defines.events.on_robot_built_entity, on_ent_create)
script.on_event(defines.events.on_built_entity, on_ent_create)

script.on_event(defines.events.on_entity_cloned, function (event)
  local ent = event.destination
  if ent.name == "heat-pipe-thermometer" then
    log(game.table_to_json(event))
    log(ent.position)
    global.temp_sensors = global.temp_sensors or {}
    find_and_bind_heatpipe(ent)
  end
end
)

script.on_init(function(event)
  global.temp_sensors = {}
end)

script.on_event(defines.events.on_tick, function(event)
  -- TODO, run each thermometer on a different tick
  -- example code: if (entity.unit_number + game.tick) % 60 == 0 then
  if event.tick % 60 == 0 then
    global.temp_sensors = global.temp_sensors or {}
    for uid,struct in pairs(global.temp_sensors) do
      local entity = struct.thermometer
      if entity.valid then
        if struct.heatpipe then
          local control = entity.get_or_create_control_behavior()
          control.set_signal(1, { signal = { type = "virtual", name = "signal-T" }, count = struct.heatpipe.temperature })
        else
          find_and_bind_heatpipe(entity)
        end
      else
        global.temp_sensors[uid] = nil
      end
    end
  end
end)
