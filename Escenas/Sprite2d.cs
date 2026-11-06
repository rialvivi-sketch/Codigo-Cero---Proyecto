using Godot;

public partial class Jugador : CharacterBody2D
{
	[Export]
	public float Velocidad = 200f;

	public override void _PhysicsProcess(double delta)
	{
		Vector2 direccion = Input.GetVector(
			"ui_left",
			"ui_right",
			"ui_up",
            "ui_down"
		);

		Velocity = direccion * Velocidad;
		MoveAndSlide();
	}
}
