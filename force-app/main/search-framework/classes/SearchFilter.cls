/**
 * Created by Dmitry Bobylev on 05.09.2019.
 */

public interface SearchFilter {
    List<String> getFields();
    SObjectType getSObjectType();
    String getFilterString();
 }