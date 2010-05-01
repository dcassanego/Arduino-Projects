#define R1 32
#define R2 22
#define R3 23
#define R4 27

#define C1 29
#define C2 28
#define C3 24
#define C4 25

typedef struct {
  short row;
  short column;
} coordinate;

//for some strange reason, the arduino coding environment doesn't let me declare
//typedefs as paramters to a function.  need to use void* and then cast.
void matrixwrite(void *voidarr, int len, long duration)
{
  int i=0;
  coordinate *arr;
  
  long endtime=millis()+duration;
  arr = (coordinate *)voidarr;
  
  while (millis() < endtime) {

    digitalWrite(R1, (arr[i].row == 1));
    digitalWrite(R2, (arr[i].row == 2));
    digitalWrite(R3, (arr[i].row == 3));
    digitalWrite(R4, (arr[i].row == 4));
    
    digitalWrite(C1, (arr[i].column == 1));
    digitalWrite(C2, (arr[i].column == 2));
    digitalWrite(C3, (arr[i].column == 3));
    digitalWrite(C4, (arr[i].column == 4));
    
    //without the delay, the effect of alternating the lights doesn't work
    delay(1);
    if (++i == len) i=0;  
  }
}

void setup()
{
  int i=0;
  
  for (i=22; i<=53; i++){
    pinMode(i, OUTPUT);  
  }
  Serial.begin(9600);
}

void loop()
{
  // simple sample pattern to demo functionality  
  coordinate c[4];
  
  c[0].row=2;
  c[0].column=2;
  matrixwrite(c, 1, 200);
  
  c[0].row=2;
  c[0].column=3;
  matrixwrite(c, 1, 200);
  
  c[0].row=3;
  c[0].column=3;
  matrixwrite(c, 1, 200);
  
  c[0].row=3;
  c[0].column=2;
  matrixwrite(c, 1, 200);
  
  c[0].row=2;
  c[0].column=2;
  c[1].row=2;
  c[1].column=3;
  c[2].row=3;
  c[2].column=3;
  c[3].row=3;
  c[3].column=2;
  matrixwrite(c, 4, 500);
  
  c[0].row=1;
  c[0].column=2;
  c[1].row=1;
  c[1].column=3;
  c[2].row=4;
  c[2].column=2;
  c[3].row=4;
  c[3].column=3;
  matrixwrite(c, 4, 200);
  
  c[0].row=1;
  c[0].column=1;
  c[1].row=1;
  c[1].column=4;
  c[2].row=4;
  c[2].column=1;
  c[3].row=4;
  c[3].column=4;
  matrixwrite(c, 4, 200);
  
  c[0].row=2;
  c[0].column=1;
  c[1].row=2;
  c[1].column=4;
  c[2].row=3;
  c[2].column=1;
  c[3].row=3;
  c[3].column=4;
  matrixwrite(c, 4, 200);
  
  c[0].row=2;
  c[0].column=1;
  c[1].row=2;
  c[1].column=4;
  c[2].row=3;
  c[2].column=2;
  c[3].row=3;
  c[3].column=3;
  matrixwrite(c, 4, 200);
  
  c[0].row=2;
  c[0].column=1;
  c[1].row=2;
  c[1].column=2;
  c[2].row=2;
  c[2].column=3;
  c[3].row=2;
  c[3].column=4;
  matrixwrite(c, 4, 200);
  
  c[0].row=2;
  c[0].column=1;
  c[1].row=2;
  c[1].column=2;
  c[2].row=2;
  c[2].column=3;
  c[3].row=3;
  c[3].column=1;
  matrixwrite(c, 4, 600);
  
  c[0].row=2;
  c[0].column=1;
  c[1].row=2;
  c[1].column=2;
  c[2].row=4;
  c[2].column=1;
  c[3].row=3;
  c[3].column=1;
  matrixwrite(c, 4, 600);
  
  c[0].row=2;
  c[0].column=1;
  c[1].row=4;
  c[1].column=2;
  c[2].row=4;
  c[2].column=1;
  c[3].row=3;
  c[3].column=1;
  matrixwrite(c, 4, 600);
  
  c[0].row=4;
  c[0].column=3;
  c[1].row=4;
  c[1].column=2;
  c[2].row=4;
  c[2].column=1;
  c[3].row=3;
  c[3].column=1;
  matrixwrite(c, 4, 600);
  
  c[0].row=4;
  c[0].column=3;
  c[1].row=4;
  c[1].column=2;
  c[2].row=4;
  c[2].column=1;
  c[3].row=4;
  c[3].column=4;
  matrixwrite(c, 4, 600);
}
