using Microsoft.VisualStudio.TestTools.UnitTesting;
using Xunit;
using FluentAssertions;

namespace PhotoMosaicV2API.Tests
{
    [TestClass]
    public class UnitTest1
    {
        [DataTestMethod()]
        [DataRow("Hello Worlds")]
        public void GetMessageTest(string expected)
        {
            Hello hello = new Hello();

            string result = hello.GetMessage();

            Assert.AreEqual(result, expected);
        }
    }
}