using Microsoft.VisualStudio.TestTools.UnitTesting;
using Xunit;
using FluentAssertions;
using PhotoMosaicV2;

namespace PhotoMosaicV2.Tests
{
    [TestClass]
    public class UnitTest1
    {
        [DataTestMethod()]
        [DataRow("Hello World")]
        public void GetMessageTest(string expected)
        {
            Hello hello = new Hello();

            string result = hello.GetMessage();

            Assert.AreEqual(result, expected);
        }
    }
}