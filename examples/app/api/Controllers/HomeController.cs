using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using code.Models;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Collections;
using System.Runtime.Serialization.Json;

namespace code.Controllers
{
[Route("api/[controller]")]
public class HomeController : Controller
{
    private readonly HttpClient httpClient;

    public HomeController(HttpClient httpClient){
        this.httpClient = httpClient;
    }
    public async Task<IActionResult> Get()
    {
        var result = await Task.WhenAll(Enumerable.Range(0,5).Select(x => GetRandomPostcodeAsync()));
        return Ok(result);
    }

    private async Task<PostcodeResponse> GetRandomPostcodeAsync(){
        string url = $"http://api.postcodes.io/random/postcodes";
        var result = await GetAsync<PostcodeResponse>(url);
        await GetNearestPostcodesAsync(result.result.postcode);
        return result;
    }

    private async Task GetNearestPostcodesAsync(string postCode){
        string url = $"http://api.postcodes.io/postcodes/{postCode}/nearest";
        var result = await GetAsync<NearestPostCodeResponse>(url);
        await Task.WhenAll(result.result.Select(x => GetGeocodeAsync(x.latitude, x.longitude)));
    }

    private async Task GetGeocodeAsync(double lat, double lng){
        string url = $"https://geocode.xyz/{lat},{lng}?geoit=json";
        await GetAsync<GeocodeResponse>(url);
    }

    private async Task<T> GetAsync<T>(string url) where T : class{
        var serializer = new DataContractJsonSerializer(typeof(T));
        var result = httpClient.GetStreamAsync(url);
        return serializer.ReadObject(await result) as T;
    }
}
}