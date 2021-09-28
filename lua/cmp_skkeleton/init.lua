local source = {}

source.new = function()
  return setmetatable({}, { __index = source })
end

source.is_available = function()
  return vim.g['skkeleton#init']
end

source.complete = function(self, request, callback)
  local candidates = self:_get_candidates()
  local preeditlen = self:_get_pre_edit_length()

  local items = {}
  for _, cs in pairs(candidates) do
    for _, c in pairs(cs[2]) do
      local label = string.gsub(c, [[;.*$]], '')
      table.insert(items, {
        label = label,
        textEdit = {
          range = {
            start = {
              line = request.context.cursor.line,
              character = request.context.cursor.character - preeditlen,
            },
            ['end'] = {
              line = request.context.cursor.line,
              character = request.context.cursor.character,
            },
          },
          newText = label,
        },
      })
    end
  end

  callback({
    items = items,
    isIncomplete = true,
  })
end

source.resolve = function(self, completion_item, callback)
  callback(completion_item)
end

source.execute = function(self, completion_item, callback)
  callback(completion_item)
end

source._get_pre_edit_length = function(_)
  return vim.fn['denops#request']('skkeleton', 'getPreEditLength', {})
end

source._get_prefix = function(_)
  return vim.fn['denops#request']('skkeleton', 'getPrefix', {})
end

source._get_candidates = function(_)
  return vim.fn['denops#request']('skkeleton', 'getCandidates', {})
end

source._register_candidate = function(_, kana, word)
  return vim.fn['denops#request']('skkeleton', 'registerCandidate', {kana, word})
end

return source
