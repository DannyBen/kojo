Showcase all prompt actions
==================================================

See the [full TTY::Prompt reference](https://github.com/piotrmurach/tty-prompt#2-interface)

(( say 'message' ))
(( ok 'green message' ))
(( warn 'yellow message' ))
(( error 'red message' ))

- {{ keypress "Press any key..." }}
- {{ ask "Text Input:", default: 'ok' }}
- {{ multiline("Description:").join "  " }}
- {{ mask "Password:" }}
- {{ yes? "Are you sure?" }}
- {{ no? "Are you not not sure?" }}
- {{ select "Choose your destiny?", %w[Scorpion Kano Jax] }}
- {{ multi_select "Select drinks?", %w[vodka beer wine whisky bourbon] }}
- {{ enum_select "Select an editor?", %w[emacs nano vim] }}
- {{ slider 'Volume', max: 100, step: 5 }}
