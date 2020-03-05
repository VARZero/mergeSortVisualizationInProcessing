// arr is to be sorted and temp is temporal place to store sorted values.
int[] arr, temp;

// lr: To store index values to dvide arr to sort partially.
// func: To store order to sort arr.
int[][] lr;
int[] order;

// recursionCount: Counting how many recursions has been occurred, to store l, r values in lr.
// recursionClosingCount: Counting how recursions has been ended, to find order to sort arr.
int recursionCount = 0;
int recursionClosingCount = 0;

// divide(): To find l, r vlaues to divide arr to sort partially.
// Initially, l will be 0 and r will be length of arr - 1.
void divide(int l, int r) {
  if(l != r) {
    // To store index value to find order. #1
    int currentRecursionCount = recursionCount;
    
    int m = (l + r) / 2;
    
    // Store l, r values to lr.
    lr[recursionCount][0] = l;
    lr[recursionCount][1] = r;
    recursionCount++;
    
    divide(l, m);
    divide(m + 1, r);
    
    // Record order of resursion closing. #1
    order[recursionClosingCount] = currentRecursionCount;
    recursionClosingCount++;
  }
}

// To counting index values to sort arr. #2
int l, r, m, t, u, v, index;
void setup() {
  // Initial setting.
  //fullScreen();
  size(640, 480);
  background(0);
  int length = width;
  
  // arr initialization. (Reversed order)
  arr = new int[length];
  for(int i = 0; i < length; i++)
    arr[i] = length - i;
  // randomizing arr
  for(int i = 0; i < length; i++) {
    int x = (int)random(0, length - 1);
    int temp = arr[i];
    arr[i] = arr[x];
    arr[x] = temp;
  }
  
  // Initialization of temp, lr and order.
  temp = new int[length];
  lr = new int[length][2];
  order = new int[length];
  
  divide(0, arr.length -  1);
  
  // Variations initializing. #2
  index = 0;
  l = lr[order[index]][0];
  r = lr[order[index]][1];
  m = (l + r) / 2;
  t = l;
  u = m + 1;
  v = l;
}

// continue_: To check whether continue or stop. #3
// drawing: Index value to draw rectangles.
int continue_ = 1;
int drawing = l;
void draw() {
  // Initial Setting
  background(0);
  stroke(255);
  fill(255);
  
  // len: Length of the single rectengle.
  // scl: Scale to stretch the length of the rectangles to fill the screen.
  float len = width / (float)arr.length;
  float scl = height / (float)arr.length;
  // Notice: This scl method is only works where the maximun value of the array is the length of the array.
  // If the maximum value of the array is not the length, put maximum value of the array insted of the length of the array.
  
  // Drawing rectangles.
  for(int i = 0; i < arr.length; i++)
      rect(i * len, height, len, - arr[i] * scl);
  
  // Sort Start.
  // Sorting arr untill index reached the end of arr.
  if(index != arr.length) {
    if(continue_ == 1) {
      // Actuall sorting part #2
      while(t != m + 1 && u != r + 1) {
        if(arr[t] < arr[u])
          temp[v++] = arr[t++];
        else
          temp[v++] = arr[u++];
      }
      
      while(v != r + 1) {
        if(t == m + 1)
          temp[v++] = arr[u++];
        else
          temp[v++] = arr[t++];
      }
    }
    
    // To draw step by step. #3
    if(drawing <= r) {
      for(int i = l; i <= drawing; i++)
        arr[i] = temp[i];
      drawing++;
      continue_ = 0;
    } else {
      if(index != arr.length - 1) {
        // To pick next l, r values to sort arr.
        drawing = lr[order[index + 1]][0];
        continue_ = 1;
      }
    }
  }
  
  if(continue_ == 1) {
    // To go to next step.
    index++;
    
    // Variations for next step. #2
    if(index != arr.length) {
      l = lr[order[index]][0];
      r = lr[order[index]][1];
      m = (l + r) / 2;
      t = l;
      u = m + 1;
      v = l;
    }
  }
  
  // End loop when index reached the end of the arr.
  if(index == arr.length)
    noLoop();
}
