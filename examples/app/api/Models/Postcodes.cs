using System.Collections.Generic;

namespace code.Models
{
public class Codes
{
    public string admin_district { get; set; }
    public string admin_county { get; set; }
    public string admin_ward { get; set; }
    public string parish { get; set; }
    public string parliamentary_constituency { get; set; }
    public string ccg { get; set; }
    public string nuts { get; set; }
}

public class Result
{
    public string postcode { get; set; }
    public int quality { get; set; }
    public int eastings { get; set; }
    public int northings { get; set; }
    public string country { get; set; }
    public string nhs_ha { get; set; }
    public double longitude { get; set; }
    public double latitude { get; set; }
    public string european_electoral_region { get; set; }
    public string primary_care_trust { get; set; }
    public string region { get; set; }
    public string lsoa { get; set; }
    public string msoa { get; set; }
    public string incode { get; set; }
    public string outcode { get; set; }
    public string parliamentary_constituency { get; set; }
    public string admin_district { get; set; }
    public string parish { get; set; }
    public string admin_county { get; set; }
    public string admin_ward { get; set; }
    public string ccg { get; set; }
    public string nuts { get; set; }
    public Codes codes { get; set; }
}

public class PostcodeResponse
{
    public int status { get; set; }
    public Result result { get; set; }
}

public class NearestPostCodeResponse{
    public int status { get; set; }
    public List<Result> result { get; set; }
}
}