// A Taste

// singletons
object Upper {
  def upper(strings: String*) = strings.map(_.toUpperCase)
}
println(Upper.upper("A", "First", "Scala"))

// shapes
//
case class Point(x: Double, y: Double)

abstract class Shape {
  def draw(): Unit
}

case class Circle(center: Point, radius: Double) extends Shape {
  def draw() = println ("Circle.draw: " + this)
}

case class Rectangle(lowerLeft: Point, height: Double, width: Double) extends Shape {
  def draw() = println ("Rectangle.draw: " + this)
}

case class Triangle(point1: Point, point2: Point, point3: Point) extends Shape {
  def draw() = println ("Triangle.draw: " + this)
}

// Actors
//
import scala.actors._
import scala.actors.Actor._

object ShapeDrawingActor extends Actor {
  def act() {
    loop {
      receive {
        case s: Shape => s.draw
        case "exit" => println("exiting..."); exit
        case x: Any => println("Error: Unknown message! " + x )
      }
    }
  }
}

ShapeDrawingActor.start
ShapeDrawingActor ! Circle(Point(0.0,0.0), 1.0)
ShapeDrawingActor ! Rectangle(Point(0.0,0.0), 2.0, 5.0)
ShapeDrawingActor ! Triangle(Point(0.0,0.0), Point(1.0,1.0), Point(-1.0, -1.0))
