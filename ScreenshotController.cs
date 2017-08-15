using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;
using System.IO;

public class screenShot : MonoBehaviour {

	// Used so that Xcode can identify these functions being called within Unity
	[DllImport ("__Internal")]
	private static extern void ScreenShotFunction();
	[DllImport ("__Internal")]
	private static extern void VideoShotFunction();

	// Has to be whole canvas object to remove all buttons from view while screenshot takes place
	public GameObject canvasObject;

	// Recording red circle image
	public GameObject feedbackImage;
	private bool videoPressed;

	void Start() {
		videoPressed = false;
	}

	// Camera Button Event Trigger on Pointer Down
	public void ScreenShot_Down() {
		Debug.Log ("Pressing Screenshot button. ");
		canvasObject.GetComponent <Canvas>().enabled = false;

		ScreenCapture.CaptureScreenshot ("Picture.png");
	}

	// Camera Button Event Trigger on Pointer Up
	public void ScreenShot_Up() {
		canvasObject.GetComponent <Canvas>().enabled = true;

		// Called on up to allow time to save
		if (Application.platform != RuntimePlatform.OSXEditor) {
			ScreenShotFunction ();
		}
	}

	// Video Button OnClick 
	public void VideoShot() {

		Debug.Log ("Pressing ScreenVideo button. ");

		if (!videoPressed) {
			videoPressed = true;
			feedbackImage.SetActive (true);
		}
		else {
			videoPressed = false;
			feedbackImage.SetActive (false);
		}

		if (Application.platform != RuntimePlatform.OSXEditor) {
			VideoShotFunction ();
		}
	}





}
