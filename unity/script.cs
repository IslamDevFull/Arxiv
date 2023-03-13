using UnityEngine;

public class script : MonoBehaviour
{
    public Rigidbody rb;
    public float tugriYurishTezligi = 200f;
    public float chapUngTezligi = 100f;
    public float sakrashTezligi = 100f;

    protected bool chapTomon = false;
    protected bool ungTomon = false;
    protected bool sakrash = false;

    void Update()
    {
        if(Input.GetKey("a"))
        {
            chapTomon = true;
        }
        else
        {
            chapTomon = false;
        }
        if(Input.GetKey("d"))
        {
            ungTomon = true;
        }
        else
        {
            ungTomon = false;
        }
        if(Input.GetKeyDown("space"))
        {
            sakrash = true;
        }
    }

    void FixedUpdate(){
        rb.AddForce(0,0,tugriYurishTezligi * Time.deltaTime);
        // rb.MovePosition(transform.position + Vector3.forward * tugriYurishTezligi * Time.deltaTime);

        if(chapTomon)
        {
            rb.AddForce(-chapUngTezligi * Time.deltaTime, 0, 0, ForceMode.VelocityChange);
        }
        if(ungTomon)
        {
            rb.AddForce(chapUngTezligi * Time.deltaTime, 0, 0, ForceMode.VelocityChange);
        }
        if(sakrash)
        {
            rb.AddForce(Vector3.up * sakrashTezligi, ForceMode.Impulse);
            sakrash = false;
        }
    }
}