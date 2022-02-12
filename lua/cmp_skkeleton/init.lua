local source = {}

source.new = function()
  return setmetatable({}, { __index = source })
end

source.is_available = function()
  return vim.fn['skkeleton#is_enabled']()
end

source.get_debug_name = function()
  return 'skkeleton'
end

source.get_keyword_pattern = function()
  return [[\%([ぁ-ゖ]\+\)]]
end

source.complete = function(self, request, callback)
  local candidates = self:_get_candidates()
  local preeditlen = self:_get_pre_edit_length()

  local items = {}
  local cnt = 0
  for _, cs in pairs(candidates) do
    local kana = cs[1]

    for _, c in pairs(cs[2]) do
      local label = string.gsub(c, [[;.*$]], '')

      local item = {
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
        filterText = kana,
      }

      local document = string.match(c, [[;.*$]])
      if document then
        item.documentation = kana .. '\n' .. string.gsub(document, [[^;]], '')
      else
        item.documentation = kana
      end

      cnt = cnt + 1
      table.insert(items, item)
    end
  end

  if cnt == 0 then
    callback()
    return
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
  local kana = completion_item.filterText
  local word = completion_item.label
  self:_register_candidate(kana, word)

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
