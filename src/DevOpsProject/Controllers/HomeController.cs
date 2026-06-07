using Microsoft.AspNetCore.Mvc;
using DevOpsProject.Models;
using System.Diagnostics;

namespace DevOpsProject.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index() => View();

    public IActionResult About() => View();

    public IActionResult Services() => View();

    public IActionResult Contact() => View(new ContactFormModel());

    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult ContactSubmit(ContactFormModel model)
    {
        _logger.LogInformation("Contact form submitted by {Name} ({Email}) — Service: {Service}",
            model.FullName, model.Email, model.ServiceInterest);

        TempData["Success"] = "true";
        return RedirectToAction(nameof(Contact));
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel
        {
            RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier
        });
    }
}
