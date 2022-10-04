return setmetatable({}, {
  __index = function(_, key)
    return key
  end,
})
