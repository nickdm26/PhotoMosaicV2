using Microsoft.AspNetCore.Mvc;

namespace PhotoMosaicV2.Areas.Settings.Controllers
{
    public class LoginController : Controller
    {
        [Area("Settings")]
        public IActionResult Index()
        {
            return View();
        }
    }
}
