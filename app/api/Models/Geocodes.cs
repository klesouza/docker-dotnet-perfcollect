namespace code.Models
{
    public class Loc
{
    public string staddress { get; set; }
    public string stnumber { get; set; }
    public string prov { get; set; }
    public string city { get; set; }
    public string postal { get; set; }
}

public class Alt
{
    public Loc loc { get; set; }
}

public class RemainingCredits
{
}

public class GeocodeResponse
{
    public string staddress { get; set; }
    public string stnumber { get; set; }
    public string country { get; set; }
    public string inlatt { get; set; }
    public Alt alt { get; set; }
    public string distance { get; set; }
    public string postal { get; set; }
    public string region { get; set; }
    public string latt { get; set; }
    public string longt { get; set; }
    public string city { get; set; }
    public string prov { get; set; }
    public RemainingCredits remaining_credits { get; set; }
    public string confidence { get; set; }
    public string inlongt { get; set; }
}
}