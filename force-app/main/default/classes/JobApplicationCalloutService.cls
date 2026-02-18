public class JobApplicationCalloutService {

    public static String sendJobApplication(Id jobAppId) {

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Dummy_API/posts');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');

        String body = JSON.serialize(new Map<String, Object>{
            'jobApplicationId' => jobAppId,
            'status' => 'Interviewing'
        });

        req.setBody(body);

        Http http = new Http();
        HttpResponse res = http.send(req);

        return res.getBody();
    }
}