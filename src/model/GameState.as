package model
{
	public class GameState
	{
		private  var _stateName:String
		public function GameState(p_stateName:String)
		{
			_stateName = p_stateName;
		}
		
		public function toString():String
		{
			return _stateName;
		}
		
		public static const INIT:GameState = new GameState("init");
		public static const MAIN_MENU:GameState = new GameState("main menu");
		public static const CREATE_NEW_GAME:GameState = new GameState("create new game");
		public static const RUNNING_LOCAL_MULTIPLAYER_GAME:GameState = new GameState("running local multiplayer game");
		public static const LOAD_GAME:GameState = new GameState("load game");
		public static const END_SCREEN:GameState = new GameState("end screen");
	}
}