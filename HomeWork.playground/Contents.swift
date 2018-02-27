// YONG SHAO


import UIKit

//Show me a example code of optional, declaration and it's use
var opt : String? = "Hello"
print ("demonstrate the use of optional variable: \(opt!)")


//Show me a example code of coalescing operator, declaration and it's use
print ("demonstrate the use of coalescing operator: \(opt ?? "opt is Nil")")


//Difference between if let and guard let
/*
 if let check whetehr the optional contains a value. If so, assign that value to the temporary constant, which is only available within the if brackets.
 guard let always has an else clause. When the condition is false, else statement executes which usually exit the method. If the condition is true, the code after the guard statement gets executed. Different from the if let, the constant or variable that were assigned valuse within the guard let syntax are available outside the guard brackets.
 */
if let optUnwrap = opt {
    print("demonstate the use of if let: \(optUnwrap)")
}else{
    print("opt is Nil")
}

func testGuardLet() {
    guard let optUnwrap = opt else {
        print("opt is Nil")
        return
    }
    print("demonstrate the use of guard let: \(optUnwrap)")
}
testGuardLet()


//Show me example of implicitly unwrapped optional through code.
let implicitOptional : String! = "implicitly unwrpped optional"
let implicitValue = implicitOptional
print("demonstrate implicitely unwarpped optional: \(implicitValue)")


//Show me a example code of property observer use case.
var number : Int = 0 {
    willSet (newNumber){
        print("About to set new value: \(newNumber)")
    }
    didSet (oldNumber){
        print("Just changed from \(oldNumber)")
    }
}
number = 5


//Show me example code how to use computed property
struct Point {
    var x = 0.0
    var y = 0.0
}

struct Rectangle {
    var width = 0.0
    var height = 0.0
    var origin = Point()
    var size: Double {
        get {
            return width * height
        }
    }
    var center: Point {
        get {
            return Point(x: origin.x + width / 2,
                         y: origin.y + height / 2)
        }
        
        set(newCenter) {
            origin.x = newCenter.x - width / 2
            origin.y = newCenter.y - height / 2
        }
    }
}

var rect = Rectangle()
rect.width = 20
rect.height = 10
print(rect.size)

rect.origin = Point(x: 0, y: 0)
print(rect.center)


//show me example code how to use stored property
struct Person {
    var name : String
    var age : Int
}

var person = Person(name: "Jack", age: 20)
print(person)


//Example code for deep copy
class PersonClass: NSObject, NSCopying {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = PersonClass(name: name, age: age)
        return copy
    }
}
let aPerson = PersonClass(name: "John", age: 25)
let aPersonObj = aPerson.copy() as! PersonClass
aPersonObj.name = "Emma"
print(aPerson.name)

//Example code of swallow copy
var anotherPerson = aPerson
anotherPerson.name = "Tom"
print(aPerson.name)


//Example code of pass by value
func passByValue (name : String, age : Int){
    
}

//Example code of pass by reference
func passByReference (person : PersonClass){
    
}

//Example code of Copy on write, or you can write in comment
var array1 = [1 , 2, 3, 4, 5]
var array2 = array1 //to boost the performance of the app. at this step, the two arrays share the same instance. So if we have a very large array, the app don't consume too much resource
array1.append(6) //at this step, array1 is changed. Now the two arrays have different copies.



//Read about basic generics, show me some basic use cases and code
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}


//Read and code about high order functions map, flatmap, filter etc.
var array = [1, 2, 3, 4, 5]
let mapArr = array.map{$0 + 5}
print(mapArr)
let isEven = array.map {$0 % 2 == 0}
print (isEven)

let arrayToBeFlatted = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]]
let flatArray = arrayToBeFlatted.flatMap{$0}
print (flatArray)

let arrayFiltered = array.filter{$0 > 3}
print(arrayFiltered)



//Show me difference between static vs class function through code.
class Animal{
    class func eat(){
        print("Animals eat meat and vegetable")
    }
    static func drink(){
        print("Animals drink water")
    }
}
class Carnivore : Animal {
    override class func eat(){
        print("Carnivores only eat meat")
    }
    //override static func drink(){}  error, static function cannot be overridden
}


//Example of type alias
typealias Intalias = Int
let x1 : Intalias = 1
let y1 : Intalias = 2
print (x1 + y1)

protocol changeName{
    func changeNameTo(name:String)
}
protocol changeAge{
    func changeAgeTo(age:Int)
}
typealias changeProtocol = changeName & changeAge



//Show me code for enum usage raw and associated
enum Numbers : Int {
    case one = 1
    case two = 2
}
var numberToCompare = 1
switch numberToCompare {
case 1:
    print ("number is 1")
case 2:
    print ("number is 2")
default:
    print ("number > 2")
}



enum WithdrawalResult{
    case Success(Int)
    case Fail(String)
}
struct BankAccount{
    var cash = 100
    mutating func withdraw(amount : Int) -> WithdrawalResult {
        if (amount <= cash) {
            cash -= amount
            return .Success(cash)
        } else {
            return .Fail("Not enough money")
        }
    }
}
var bankAccount = BankAccount()
let result = bankAccount.withdraw(amount: 99)
let result2 = bankAccount.withdraw(amount: 199)



//Show me a code to show how ARC works
class PersonARC{
    let name: String
    init (name: String){
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
var personArcObj : PersonARC?
personArcObj = PersonARC(name: "Joe")
personArcObj = nil


//Show me a code of reference cycle
class Person2 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person2?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
var john: Person2?
var unit4A: Apartment?
john = Person2(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
john!.apartment = unit4A
unit4A!.tenant = john
john = nil
unit4A = nil


//Show me a code of solving a reference cycle
class Person3 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment2?
    deinit { print("\(name) is being deinitialized") }
}
class Apartment2 {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person3?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
var olive: Person3?
var unit5B: Apartment2?
olive = Person3(name: "olive Appleseed")
unit5B = Apartment2(unit: "5B")
olive!.apartment = unit5B
unit5B!.tenant = olive
olive = nil



//Show me different use cases of try catch, try?, try!

enum NameError: Error {
    case noName
}

class Course {
    var name: String
    init(name: String) throws {
        if name == "" {
            throw NameError.noName
        } else {
            self.name = name
            print ("You've created an object!")
        }
    }
}

do {
    let myCourse = try Course(name : "")
} catch NameError.noName {
    print("Please enter a valid name")
}

//try is only used within a do-catch block. However, try? and try! can be used without it.
//try? returns an optional type. If it throws an error, the result will be nil.
let newCourse = try? Course(name: "I am the Dev")
print (newCourse)
let newDopeCourse = try? Course(name: "")
print (newDopeCourse?.name)

//try! returns a normal type. If the method/init throws an error, it will crash
let myNewCourse = try! Course(name: "xxx")
//let myNewCourse = try! Course(name: "") it crash



//Show me code how to use lazy properties
class A {
    var name = "Ben"
}
class B {
    lazy var a = A()
    var data = [String]()
}
let b = B()
b.data.append("test") // instance of class A has not been initialized
b.a.name = "Green" // instance of class a is initialized
print(b.a.name)


//Differences between value types and reference types
/*  value types store their content in memory. When we declare a value type, a single space in memory is allocated to store the value. If we assign it to another variable, the value is copied directly and both variables work independently.
  reference types are used by a reference that holds address of the object. assigning a reference variable to another doesn't copy the data. Instead it creates a second copy of the reference, which refers to the same memory address.
 In Swift, only class is reference type.
 */


//Difference between class, struct, enums
/* Class is reference type. Struct and enum are value type. Classes have deinitializer. In contrast, struct and enum do not have deinitializer. Classes have inheritance. Struct and enum don't. Enum defines a common type for a group of related values and enables you to work with those values.
 
 */


//Show me  different uses of access modifiers.
/* public class ABC{
 }
 
 internal struct CDE{
 }
 
 fileprivate let var : Int
 
 private let var2 : Int
 */








let numFloors = 3
let length = 3
let steps = 4
let pizzaPrice = 60

func Rock(_ steps : Int) {
    for _ in 0..<steps {
        print("Rock")
    }
}

func Roll(_ meters : Int) {
    for _ in 0..<meters {
        print("Roll")
    }
}

func Turn(_ side : String) {
    print("Turn(\(side))")
}

func Door(_ action : String) {
    print("Door(\(action))")
}

func Charge(_ amount : Int) {
    print("Charge(\(amount))")
}

func Deliver(_ item : String) {
    print("Deliver(\(item))")
}

Door("Open")
for _ in 1...numFloors {
    Roll(length)
    Turn("Left")
    Rock(steps)
    Turn("Left")
}
Roll(length)
Turn("Right")
Door("Knock")
Charge(pizzaPrice)
Deliver("Pizza")







