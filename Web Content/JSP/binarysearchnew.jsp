<%
String email=(String)session.getAttribute("email");
if(email==null)
{
	response.sendRedirect("index.jsp");
}
else
{
%>

<!DOCTYPE html>
<html>
 <head>
    <title>Binary Search Animation</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/boxes.css" />
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/jquery.ui.touch-punch.min.js"></script>
<script src="js/jquery.alerts.js"></script> 
<link href="css/jquery.alerts.css" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="js/GetElementPosition.js"></script>
    <link rel="stylesheet" type="text/css" href="css/codecolor.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
	body {
        background-color:WhiteSmoke ;
} 
      #highlight {
          background-color:lightcoral;
          opacity: 1.0;
          color: black;
          weight: bold;
          position:absolute;
          width:315px;
          height: 35px;
          /*          padding: 3px;
                    margin-top:0px;*/
          top: 79px;
          left: 62px;
      }

      #explanation1 {
          background-color:lightcoral;
          opacity: 1.0;
          color: black;
          weight: bold;
          position:absolute;
          width:315px;
          height: 35px;
          /*          padding: 3px;
                    margin-top:0px;*/
          top: 79px;
          left: 62px;
      }
	.center {
    display: block;
    margin-left: auto;
    margin-right: auto;
    width: 40%;
}
      .cell {
          position:absolute;
          width:40px;
          height: 40px;
          left:20px;
          top:40px;
          border-width: 2px;
          border: 1px black solid;
          background-color: white;
          text-align: center;
          display:inline;
      }

      .cell1 {
          display:inline;
      }

      div.inline { float:left; }
      .clearBoth { clear:both; }

      .button {
          margin-bottom: 0px; margin-top: 0px; background-color: #37826c; color:white;
          /*    width: 70px;
              height: 30px;*/
          display:inline;
          color:#fff;
          font-size: 14px;
          background: #6193CB;
          border: none;
      }

    </style>

    <script>
      function init() {
          reset();
      }

      function reset() {
          low = 0;
          high = SIZE - 1;
          i = 0;
          document.getElementById('highlight').style.visibility = 'hidden';
          document.getElementById('lowPosition').style.visibility = 'hidden';
          document.getElementById('lowValue').style.visibility = 'hidden';
          document.getElementById('midPosition').style.visibility = 'hidden';
          document.getElementById('midValue').style.visibility = 'hidden';
          document.getElementById('highPosition').style.visibility = 'hidden';
          document.getElementById('highValue').style.visibility = 'hidden';
          setRandomValue();
          resetColor();
          document.getElementById('remark').innerHTML = 'A new random list is created';
          document.getElementById('value').disabled = false;
          for (var j = 0; j < SIZE; j++) {
              id = 'check' + j;
              document.getElementById(id).innerHTML = "";
          }
      }

      function resetColor() {
          for (var i = 0; i < SIZE; i++) {
              id = 'list' + i;
              document.getElementById(id).style.backgroundColor = "white";
              document.getElementById(id).style.color = "#37826c";
          }
      }

      function sortNumber(a, b) {
          return a - b;
      }

      function setRandomValue() {
          listValues = [];
          for (var i = 0; i < SIZE; i++) {
              listValues.push(Math.floor(Math.random() * 100));
          }
          listValues.sort(sortNumber);
          for (var i = 0; i < SIZE; i++) {
              id = 'list' + i;
              document.getElementById(id).innerHTML =
                      listValues[i];
          }
      }

      function draw() {
          var count = 0;
          for (var i = 0; i < 1; i++) {
              for (var j = 0; j < 20; j++) {
                  id = 'cell' + j;
                  // document.write(id.toString());
                  document.getElementById(id).style.top = (i + 1) * 40 + 30 + "px";
                  document.getElementById(id).style.left = (j + 1) * 40 + "px";
//                  if (count++ % 2 == 0)
//                      document.getElementById(id).style.backgroundColor = "#37826c";
//                  else
//                      document.getElementById(id).style.backgroundColor = "lightGray";

                  document.getElementById(id).innerHTML = "2";
              }
              count++;
          }
      }

      function step() {
                  document.getElementById('lowPosition').style.visibility = 'visible';
          document.getElementById('lowValue').style.visibility = 'visible';
          document.getElementById('highPosition').style.visibility = 'visible';
          document.getElementById('highValue').style.visibility = 'visible';
          
          var idLow = 'list' + low;
          posLow = getElementPos(document.getElementById(idLow));
          document.getElementById('lowPosition').style.top
                  = posLow.y - 30 + "px";
          document.getElementById('lowPosition').style.left
                  = posLow.x + posLow.w / 2 - 5 + "px";
          document.getElementById('lowValue').style.top
                  = posLow.y - 43 + "px";
          document.getElementById('lowValue').style.left
                  = posLow.x + posLow.w / 2 - 18 + "px";
          document.getElementById('lowValue').innerHTML = "low: " + low;


          var idHigh = 'list' + high;
          posHigh = getElementPos(document.getElementById(idHigh));

          if (high != low) {
              document.getElementById('highPosition').style.top
                      = posHigh.y - 48 + "px";
              document.getElementById('highPosition').style.left
                      = posHigh.x + posHigh.w / 2 - 5 + "px";
          } else {
              document.getElementById('highPosition').style.visibility = 'hidden';
          }

          document.getElementById('highValue').style.top
                  = posHigh.y - 63 + "px";
          document.getElementById('highValue').style.left
                  = posHigh.x + posHigh.w / 2 - 18 + "px";
          document.getElementById('highValue').innerHTML = "high: " + high;


          if (high < low) {
              var id1 = 'check' + i;
              document.getElementById(id1).innerHTML = "&#x2717;";
              document.getElementById('remark').innerHTML =
                      'No match and the search is exhausted.';
              jAlert("No match. Search is finished. The method will return " + (-1 - low) + ".");

              return;
          }

          document.getElementById('midPosition').style.visibility = 'visible';
          document.getElementById('midValue').style.visibility = 'visible';

          mid = Math.floor((low + high) / 2);

          document.getElementById('value').disabled = true;
          var key = document.getElementById('value').value;
          i = mid;
          var id = 'list' + i;
          posLoc = getElementPos(document.getElementById(id));

          if (mid == low || mid == high) {
              document.getElementById('midPosition').style.visibility = 'hidden';
          }
          else {
              document.getElementById('midPosition').style.top
                      = posLoc.y - 40 + "px";
              document.getElementById('midPosition').style.left
                      = posLoc.x + posLoc.w / 2 - 5 + "px";
          }

          document.getElementById('midValue').style.top
                  = posLoc.y - 53 + "px";
          document.getElementById('midValue').style.left
                  = posLoc.x + posLoc.w / 2 - 18 + "px";
          document.getElementById('midValue').innerHTML = "mid: " + i;

          document.getElementById('highlight').style.top =
                  posLoc.y + posLoc.h + 30 + "px";
          document.getElementById('highlight').style.left =
                  posLoc.x + "px";
          document.getElementById('highlight').style.width =
                  posLoc.w + "px";
          document.getElementById('highlight').style.height =
                  posLoc.h + 10 + "px";
          document.getElementById('highlight').innerHTML = key;
          document.getElementById('highlight').style.visibility = 'visible';
          resetColor();
          document.getElementById(id).style.backgroundColor =
                  "wheat";
          document.getElementById(id).style.color = "black";
          if (key == document.getElementById(id).innerHTML) {
              var id1 = 'check' + i;
              document.getElementById(id1).innerHTML = "&#x2713;";
              document.getElementById('remark').innerHTML =
                      'A key is found';
              jAlert("A key is found with the index " + i);
              return;
          }
          else if (key < listValues[mid]) {
              high = mid - 1;
              var id1 = 'check' + i;
              document.getElementById(id1).innerHTML = "&#x2717;";
              document.getElementById('remark').innerHTML = 'Since ' +
                      key + ' is less than ' + document.getElementById(id).innerHTML + ', ' +
                      'continue to search left.';
          }
          else {
              low = mid + 1;
              var id1 = 'check' + i;
              document.getElementById(id1).innerHTML = "&#x2717;";
              document.getElementById('remark').innerHTML = 'Since ' +
                      key + ' is greater than ' + document.getElementById(id).innerHTML + ', ' +
                      'continue to search right.';
          }



      }

      function init1() {
          posLoc = getElementPos(document.getElementById('program'));
          x = posLoc.x;
          y = posLoc.y;
          for (var i = 0; i < 1; i++) {
              for (var j = 0; j < 20; j++) {
                  var id = 'cell' + j;
//                document.getElementById(id).style.visibility = "hidden";
                  document.getElementById(id).style.top = y + i * 40 + "px";
                  document.getElementById(id).style.left = x + j * 40 + "px";
//                  $(id).css("top", y + 90 + j * 40)
//                          .css("left", x + 115 - 3 / 2 + i * 40);
              }
          }
      }

    </script>
  
</head>



  <body onload="init()" onresize="" style="font-family: times new roman;"> 
    <h3 align="center"><b>Binary Search Animation</b></h3>
	<h4 align="center"> 
	 
      Usage: Enter a key as a number. Click the Step button to perform one comparison.
	  Click the Reset button to start over with a new random list of integers.<br/>
	  You may enter a new key for a new search.
     
    </h4>
    
	<img align ="center" src="images/binarysearch.png" class="center">
<!DOCTYPE html>
<title>Text Example</title>
<style>
div.container {
background-color: #303030;
}
div.container p {
font-family: Arial;
font-size: 18px;
font-style: normal;
font-weight: bold;
text-decoration: none;
text-transform: none;
color: #000000;
background-color: #ffffff;
}
</style>

<div class="container">
</div>
    <div style="height: 70px; font-size: 200%"></div>
    <div id ="lowValue" style="position: absolute; font-size: 70%;">low: 0</div>
    <div id ="lowPosition" style="position: absolute; font-size: 140%">&#8595;</div>

    <div id ="midValue" style="position: absolute; font-size: 70%;">mid: 1</div>
    <div id ="midPosition" style="position: absolute; font-size: 200%">&#8595;</div>

    <div id ="highValue" style="position: absolute; font-size: 70%;">high: 1</div>
    <div id ="highPosition" style="position: absolute; font-size: 230%">&#8595;</div>

    <div style="display: table; overflow: hidden; width: 90%; margin: 0 auto;">
      <script>
        SIZE = 10;
        for (var i = 0; i < SIZE; i++) {
            document.writeln('<div style="display: table-cell;background-clip: padding-box;border-radius: 5px; vertical-align: middle;' +
                    'border: 1px blue solid; background: white;' +
                    'width: 30px; height: 30px; max-width: 30px; text-align: center;">' +
                    '<div id="list' + i + '" style="color: wheat; background-clip: padding-box;height: 28px; weight: bold">45</div>' +
                    '</div>');
        }
      </script>      
    </div>

    <div style="display: table; overflow: hidden; width: 90%; margin: 0 auto;">
      <script>
        SIZE = 10;
        for (var i = 0; i < SIZE; i++) {
            document.writeln('<div style="display: table-cell;background-clip: padding-box;border-radius: 5px; vertical-align: middle;' +
                    ' background: WhiteSmoke;' +
                    'width: 30px; height: 10px; max-width: 30px; text-align: center;">' +
                    '<div id="check' + i + '" style="color: #EB0D1B; weight: bold"></div>' +
                    '</div>');
        }
      </script>      
    </div>

    <div style="display: table-cell; vertical-align: middle;
         background: WhiteSmoke;
         width: 30px; height: 45px; max-width: 30px; text-align: center;">
      <div id="highlight"></div>
    </div>

    <div style="text-align: center; margin-top: 1em">
      <span id = "remark" style = "background-color: chocolate; color: white; alignment-adjust: central; text-align: center; max-wdith: 800px; margin-left: auto; margin-right: auto">
        A list is filled with random numbers.
      </span>
    </div>

    <div align="center" >
      Key: <input type="text" size="5" value="24" id="value" style="text-align: right"></input>
      <button type="button" class="button" onclick="step()">Step</button>
      <button type="button" class="button" onclick="reset()">Reset</button></div>

    <div style="text-align: center; margin-top: 1em">
      <span id = "status" style = "background-color: chocolate; color: white; alignment-adjust: central; text-align: center; max-wdith: 800px; margin-left: auto; margin-right: auto">
      </span>
    </div>
  </body>

</html>

<%
}
%>