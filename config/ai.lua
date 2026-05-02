require('minuet').setup {
  provider = 'openai_fim_compatible',
  n_completions = 1,
  -- I recommend beginning with a small context window size and incrementally
  -- expanding it, depending on your local computing power. A context window
  -- of 512, serves as an good starting point to estimate your computing
  -- power. Once you have a reliable estimate of your local computing power,
  -- you should adjust the context window to a larger value.
  context_window = 512,
  request_timeout = 15,
  provider_options = {
    openai_fim_compatible = {
      api_key = 'TERM',
      name = 'Ollama',
      end_point = 'http://localhost:11434/v1/completions',
      stream = true,
      model = 'qwen2.5-coder:14b',
      template = {
        prompt = function(ctx_before_cursor, _)
          return ctx_before_cursor
        end,
        suffix = function(_, ctx_after_cursor, _)
          return ctx_after_cursor
        end,
      },
      optional = {
        max_tokens = 56,
        top_p = 0.9,
      },
    },
  },
}
