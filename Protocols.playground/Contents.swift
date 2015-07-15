import Foundation;

@objc protocol Speaker
{
    func Speak()
    optional func TellJoke()
}

class Stewie: Speaker
{
    @objc func Speak()
    {
        println("What the Deuce?")
    }
    func TellJoke()
    {
        println("You got money to buy fake mustaches!")
    }
}

class Peter: Speaker
{
    @objc func Speak()
    {
        println("Roadhouse!")
    }
}

class Lois: Speaker
{
    @objc func Speak()
    {
        println("Who wants chowda!")
    }
    func TellJoke()
    {
        println("Peta, if you shock me, I sweat to God i'm leaving you!")
    }
}

var griffin = Peter()
griffin.Speak()

