/**
 * Created by Dmitry Bobylev on 09.09.2019.
 */

public with sharing class GetRatesSimple {

    public class GetRatesResponse {
        public String base;
        public Map<String, Decimal> rates;
    }

    public Map<String, Decimal> getRates (String currencyBase) {
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:GetRates' + '?base' + currencyBase);

        Http http = new Http();
        HttpResponse res = http.send(request);
        GetRatesResponse response = (GetRatesResponse) JSON.deserialize(res.getBody(), GetRatesResponse.class);
        return response.rates;
    }
}