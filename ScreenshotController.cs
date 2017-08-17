using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;
using System.IO;

#if PLATFORM_IOS
using UnityEngine.iOS;
using UnityEngine.Apple.ReplayKit;
#endif

public class ScreenshotController : MonoBehaviour {

	// Used so that Xcode can identify these functions being called within Unity
	[DllImport ("__Internal")]
	private static extern void ScreenShotFunction();

	// Has to be the same as the one in Xcode(screenshot.mm)
	private string pictureName;

	// Has to be whole canvas object to remove all buttons from view while screenshot takes place
	public GameObject canvasObject;

	// Screenshot and video buttons
	public GameObject cameraButton;
	public GameObject videoButton;

	// Recording red circle image
	public GameObject feedbackImage;

	// Confirm Buttons
	public GameObject confirmScreenshotButton;
	public GameObject confirmVideoButton;

	// Used for video recording
	private bool recording;
	private bool videoPressed;

	void Start() {
		videoPressed = false;
	}
		

	// Camera Button Event Trigger on Pointer Down
	public void Screenshot_PointerDown() {
		canvasObject.GetComponent <Canvas>().enabled = false;

		pictureName = "Picture.png";
		ScreenCapture.CaptureScreenshot (pictureName);
	}

	public void Screenshot_PointerUp() {
		canvasObject.GetComponent <Canvas>().enabled = true;
		confirmScreenshotButton.SetActive (true);

		cameraButton.SetActive (false);
		videoButton.SetActive (false);
	}

	// Used on confirm button so that there are no race conditions in image saving
	public void ScreenshotConfirm() {
		// Run on Xcode function
		if (Application.platform != RuntimePlatform.OSXEditor) {
			ScreenShotFunction ();
		}

		// Delete file after save
		if (File.Exists (Application.persistentDataPath + "/" + pictureName)) {
			File.Delete ((Application.persistentDataPath + "/" + pictureName));
		}

		// Go back to normal GUI operation
		confirmScreenshotButton.SetActive (false);
		cameraButton.SetActive (true);
		videoButton.SetActive (true);
	}

	// Video Button OnClick 
	public void VideoShotClick() {
		if (!ReplayKit.APIAvailable) {
			Debug.Log ("API not available! ");
			return;
		}
			
		if (videoPressed) {
			videoPressed = false;

			// Turn off GUI
			feedbackImage.SetActive (false);
			videoButton.SetActive (false);

			// Show confirmation button
			confirmVideoButton.SetActive (true);

		}
		else {
			videoPressed = true;

			// Begin recording mode
			feedbackImage.SetActive (true);
			cameraButton.SetActive (false);
							
		}

		// Recording 
		recording = ReplayKit.isRecording;
		recording = !recording;
		if (recording) {
			Debug.Log ("I am starting a recording");
			ReplayKit.StartRecording();
		}
		else {
			Debug.Log ("I am ending a recording");
			ReplayKit.StopRecording();
		}
	}

	public void VideoConfirm(){
		if (ReplayKit.recordingAvailable) {
			ReplayKit.Preview();
		}

		// Go back to normal GUI operation
		confirmVideoButton.SetActive (false);
		cameraButton.SetActive (true);
		videoButton.SetActive (true);
	}
		

}
