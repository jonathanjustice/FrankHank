private function floatAround(movementObject:MovieClip, speed:int, waveHeight:int, waveLength:int, yStartPosition:int):void{
			movementObject.x += speed;
			movementObject.y = (Math.sin(movementObject.x / wavelength) * waveHeight) + yStartPosition;
		}