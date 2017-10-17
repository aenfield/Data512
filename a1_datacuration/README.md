# README: DATA 512, A1: Data curation

## Goal
The goal of this project is to show that I can "demonstrate that [I] can follow best practices for open scientific research in designing and implementing your project, and make your project fully reproducible by others: from data collection to data analysis." I'll do this by pulling data for, wrangling, and analyzing data about the amount of monthly English Wikipedia traffic from January 1, 2008 through September 30, 2017. 

The instructions for this assignment are documented [on the course wiki](https://wiki.communitydata.cc/HCDS_(Fall_2017)/Assignments#Step_1:_Data_acquisition).


## License

This code is licensed as described in the [LICENSE](LICENSE) file.

## Data

I use two different APIs to cover the full range of time from 2008 to 2017. As of the time of writing, October 16, 2017, the data provided by both of these APIs is subject to the [Wikimedia terms of use](https://wikimediafoundation.org/wiki/Terms_of_Use/en) and is available under the [CC-BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/) and [GFDL](https://www.gnu.org/copyleft/fdl.html) licenses.

### Page counts
- Data from 1/1/2008 to 7/31/2016 per the assignment wiki page (although 8/1/2008 to 7/31/2016 per class slides).
- API/access can be 'desktop-site' or 'mobile-site'.
- Data from the 'mobile-site' API starts in October 2014.
- Views from spiders/crawlers are included in the counts - the API doesn't support filtering out these page accesses.

Documentation

https://wikitech.wikimedia.org/wiki/Analytics/AQS/Legacy_Pagecounts

API docs w/ URL

https://wikimedia.org/api/rest_v1/#!/Pagecounts_data_(legacy)/get_metrics_legacy_pagecounts_aggregate_project_access_site_granularity_start_end

Sample URL 

https://wikimedia.org/api/rest_v1/metrics/legacy/pagecounts/aggregate/en.wikipedia.org/desktop-site/monthly/2008010100/2008040100

### Page views
- 7/1/2015 to present per class slides
- API/access can be 'desktop', 'mobile-app', or 'mobile-web'
- We specify 'user' for all calls because we do not want spider/crawler views

Documentation

https://wikitech.wikimedia.org/wiki/Analytics/AQS/Pageviews

API docs 

https://wikimedia.org/api/rest_v1/#!/Pageviews_data/get_metrics_pageviews_aggregate_project_access_agent_granularity_start_end

Sample URL 

https://wikimedia.org/api/rest_v1/metrics/pageviews/aggregate/en.wikipedia.org/desktop/user/monthly/2015070100/2017100100


# Fields in the output data file

| Column      	      	  | Description |
| ----------------------- | ----------- |
| pagecount_all_views.    | Sum of the pagecount_desktop_views and pagecount_mobile_views values, for this month. |
| pagecount_desktop_views | The number of page accesses from the Pagecounts API for the 'desktop-site' 'access-site' value, for this month.| 
| pagecount_mobile_views  | The number of page accesses from the Pagecounts API for the 'mobile-site' 'access-site' value, for this month. As noted previously, this data starts in October 2014.|
| pageview_all_views      | Sum of the pageview_desktop_views and pageview_mobile_views values, for this month. |
| pageview_desktop_views  | The number of page accesses from the Pageviews API for the 'desktop' 'access' value, for the 'user' 'agent' value, for this month. |
| pageview_mobile_views   | The number of page accesses from the Pageviews API for the 'mobile-app' and 'mobile-web' 'access' values, for the 'user' 'agent' value, for this month.|
| year                    | Four digit year for the counts in this row. |
| month                   | Two digit month for the counts in this row. |



