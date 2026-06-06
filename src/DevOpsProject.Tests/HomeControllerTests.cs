using Microsoft.AspNetCore.Mvc.Testing;
using Xunit;

namespace DevOpsProject.Tests;

public class HomeControllerTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly WebApplicationFactory<Program> _factory;

    public HomeControllerTests(WebApplicationFactory<Program> factory)
    {
        _factory = factory;
    }

    [Fact]
    public async Task HomePage_Returns_Success()
    {
        var client = _factory.CreateClient();
        var response = await client.GetAsync("/");
        response.EnsureSuccessStatusCode();
    }

    [Fact]
    public async Task PrivacyPage_Returns_Success()
    {
        var client = _factory.CreateClient();
        var response = await client.GetAsync("/Home/Privacy");
        response.EnsureSuccessStatusCode();
    }
}
