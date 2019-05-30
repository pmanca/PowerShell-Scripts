using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication2
{
    class Program
    {
        static void Main(string[] args)
        {

            String test1 = "hello";
            String test2 = "hello";

            Console.WriteLine(test1.Equals(test2));
            Console.WriteLine(test1.Equals("hello"));
            Console.WriteLine(test1.value() == "hello");
            Console.ReadLine();
        }
    }
}
