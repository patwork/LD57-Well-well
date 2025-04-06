extends Node

@warning_ignore("UNUSED_SIGNAL")
signal game_start

@warning_ignore("UNUSED_SIGNAL")
signal game_win

@warning_ignore("UNUSED_SIGNAL")
signal game_fail

@warning_ignore("UNUSED_SIGNAL")
signal update_player_life(value: int)

@warning_ignore("UNUSED_SIGNAL")
signal update_player_ring(value: int)

@warning_ignore("UNUSED_SIGNAL")
signal ring_passed

@warning_ignore("UNUSED_SIGNAL")
signal collected_heart

@warning_ignore("UNUSED_SIGNAL")
signal hit_by_obstacle(obstacle: MyObstacle)

@warning_ignore("UNUSED_SIGNAL")
signal controls_enabled(value: bool)
