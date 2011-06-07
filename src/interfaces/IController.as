package interfaces
{
	/**
	 * Controllers need to be prepped with their respective view and model.
	 * It is an annoying limitation, that might change. Maybe all controllers 
	 * just receive the model and handle view changes though an event system. 
	 * @author gltovar85
	 * 
	 */	
	public interface IController
	{
		function initController(p_view:IView, p_model:IModel):void;
		function startController():void;
		function stopController():void;
	}
}