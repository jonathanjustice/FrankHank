/*
to instantiate:

private function requestImages(requestingFile,array_of_fileNames){
	var il:ImageLoader = new ImageLoader();
	il.addEventListener(Event.COMPLETE, loadComplete);
	il.requestImages(requestingFile,actorImages);// see E4X
}
		
private function loadComplete(e:Event):void{
   	var tempArray = e.target.getImages();  //returns first image from Array
	for(var i:int=0;i<tempArray.length;i++){
		//do stuff with images here
		stage.addChild(tempArray[i]);
	}
}
*/
package utilities.Saving_And_Loading{
	//import assets.*;
	//Can i force to push at a specific array location, im pretty sure i will need to
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.display.Loader;
	public class ImageLoader extends EventDispatcher {
		private var numImages;
		private var currentImage;
		private var imagesArray:Array = new Array();
		private var paths;
		private var requestingFile;
		private var requester;
		
		//public function ImageLoader(paths:XMLList){
		public function ImageLoader(){
			//nothing to see here
			//move along
		}
		
		public function setUp(){
			//nothing to see here
			//move along
		}
		
		public function requestImages(requestingFile,paths:Array){
			requester = requestingFile;
			this.paths = paths;
			numImages = paths.length;
			currentImage = 0; 
			loadImage(paths[currentImage]);
		}
		
		public function loadImage(url:String){
			var loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
			loader.load(new URLRequest(url));
		}   
			
		public function onImageLoaded(e:Event){
			var image = new Bitmap(e.target.content.bitmapData.clone());
			imagesArray.splice(currentImage,0,image);
			currentImage++;
			if(currentImage < numImages){
				loadImage(paths[currentImage]);
			}else {
				//use returnImages if I want to autosend the images back without calling the loader again
				//returnImages();
				dispatchEvent(new Event(Event.COMPLETE));
				
			}
		}
		
		//send the images to file that requested them
		private function returnImages(){
			//requester.getImages(imagesArray);
		}
		
		//acess images array
		public function getImages():Array{
			//trace("imagesArray",imagesArray);
			return imagesArray;
		}
		
		//this is for testing
		public function displayImages(){
			trace("display images");
			for(var i:int=0;i<imagesArray.length;i++){
				requestingFile.addChild(imagesArray[i]);
			}
		}
	}
}