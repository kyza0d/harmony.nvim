local utils = {}

utils.get_variant = function(variant)
  if variant then
    return variant == "light" and 2 or 1
  end
  for i, x in pairs(vim.opt.background) do
    if i == "_value" then
      return x == "light" and 2 or 1
    end
  end
end

local hex2rgb = function(hex)
  -- remove leading #
  hex = hex:gsub("#", "")
  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)
  return r, g, b
end

utils.extend = function(method, t1, t2)
  return vim.tbl_deep_extend(method, {}, t1, t2)
end

utils.blend = function(color1, color2, ratio)
  local r1, g1, b1 = color1:match("#(%x%x)(%x%x)(%x%x)")
  local r2, g2, b2 = color2:match("#(%x%x)(%x%x)(%x%x)")

  -- Convert hex color codes to decimal values
  r1, g1, b1 = tonumber(r1, 16), tonumber(g1, 16), tonumber(b1, 16)
  r2, g2, b2 = tonumber(r2, 16), tonumber(g2, 16), tonumber(b2, 16)

  -- Calculate the blended color
  local r = math.floor(r1 + (r2 - r1) * ratio)
  local g = math.floor(g1 + (g2 - g1) * ratio)
  local b = math.floor(b1 + (b2 - b1) * ratio)

  -- Convert decimal values back to hex color code
  return string.format("#%02x%02x%02x", r, g, b)
end

return utils
