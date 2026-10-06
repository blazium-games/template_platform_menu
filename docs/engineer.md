# Platform Menu

One front sheet for Android, iOS, and Web. Choosing a row opens scenes/board.tscn, which runs that rule once with a passing value and once with a rejecting value.

This is a starter, not a full game. The opener stays the main scene. The follow-on scene is scenes/board.tscn. Advance only when the new rule allows it.

## Files

- scenes/opener.tscn is the main scene. The three rows live here.
- scenes/board.tscn is the follow-on scene. It shows one kept line and one rejected line.
- scripts/rules.gd holds the copied platform rules and the unknown-kind reject. There is no shared library.
- scripts/presenter.gd reads input and opens the board.
- scripts/board.gd paints the pass and the reject.
- autoload/boot_guard.gd checks the input map, clamps volume to 0..1, and pauses on halt.
- autoload/launch_events.gd sends session_start, boot_ok, first_input, session_end, and quit only after app_id and build_id are both set.
- mcp/register.gd registers the game MCP tools.
- tests/gdscript holds the Autowork tests.
- tools/check_names.py fails if a gameplay declaration matches the source template.
- docs/crash-reporting.md explains the sidecar.

## Extend

`example_ok(kind)` rejects an unknown kind. `scenes/board.tscn` shows a pass and a reject for Android, iOS, and Web. After that, add a fourth example the sheet can reject.

Change the rule first, then the scene, then the presenter. Add an Autowork test for the new reject. Run the name check before you save a new declaration.

## Editor MCP

http://127.0.0.1:6506/mcp

This is the engine catalog. Use it to inspect the scene, scripts, and Autowork tools. The project sets blazium/justamcp/server_enabled and override_editor_settings so the editor listens on 6506. Autowork tools are enabled. Headless Autowork still needs --enable-mcp or the editor host stays off. Do not dump the whole catalog. Call blazium_list_toolsets, then one toolset.

## Game MCP

http://127.0.0.1:6507/mcp

This host only exposes tools from res://mcp/register.gd:

- read_platform_menu reads the live rules on /root/Opener. If the scene is not running, the tool returns scene_down.
- reset_platform_menu resets those live rules.
- set_halt pauses through BootGuard. Pass halted, or omit it to toggle.
- exercise_platform_menu calls one rule function. Pass action and an args array. Actions: example_ok, bar_clear, notch_clear, page_ready. Names that start with an underscore are rejected. This is not eval.
- starter_brief is a prompt with this same guidance.

.cursor/mcp.json points Cursor at both hosts when this folder is the workspace.

Only one starter can listen at a time. Every starter uses ports 6506 and 6507.

## Tests

```
blazium --headless --path . -s res://run_tests.gd
python tools/check_names.py
```

Autowork can print a missing-camera line because the test runner is the main loop, and that line must not fail the process.
