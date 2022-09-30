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

return utils
