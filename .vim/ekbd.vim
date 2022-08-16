isetekbd clear

isetekbd append {
	\ 'buttons': [
		\ {
			\ 'keys': [
				\ { 'title': '⎋', 'type': 'special', 'contents': 'esc' },
				\ { 'title': '⌃', 'type': 'modifier', 'contents': 'control' },
			\ ],
			\ 'locations': [0, 1]
		\ },
		\ {
			\ 'keys': [
				\ { 'title': '⇥', 'type': 'special', 'contents': 'tab' },
				\ { 'title': '⌥', 'type': 'modifier', 'contents': 'alt' }
			\ ]
		\ },
		\ {
			\ 'keys': [
				\ { 'title': '⌃', 'type': 'modifier', 'contents': 'control' }
			\ ]
		\ },
		\ {
			\ 'keys': [
				\ { 'title': '⌥', 'type': 'modifier', 'contents': 'alt' }
			\ ]
		\ },
		\ {
			\ 'keys': [
			\ ]
		\ },
		\ {
			\ 'keys': [
				\ { 'title': '←', 'type': 'special', 'contents': 'left' },
				\ { 'title': 'home', 'type': 'command', 'contents': 'eval feedkeys("\<Home>")' }
			\ ]
		\ },
		\ {
			\ 'keys': [
				\ { 'title': '↓', 'type': 'special', 'contents': 'down' },
				\ { 'title': 'PgDn', 'type': 'command', 'contents': 'eval feedkeys("\<PageDown>")' }
			\ ]
		\ },
		\ {
			\ 'keys': [
				\ { 'title': '↑', 'type': 'special', 'contents': 'up' },
				\ { 'title': 'PgUp', 'type': 'command', 'contents': 'eval feedkeys("\<PageUp>")' }
			\ ]
		\ },
		\ {
			\ 'keys': [
				\ { 'title': '→', 'type': 'special', 'contents': 'right' },
				\ { 'title': 'end', 'type': 'command', 'contents': 'eval feedkeys("\<End>")' }
			\ ]
		\ },
		\ {
			\ 'keys': [
				\ { 'title': 'del', 'type': 'command', 'contents': 'eval feedkeys("\<Del>")' }
			\ ]
		\ }
	\ ]
\ }
