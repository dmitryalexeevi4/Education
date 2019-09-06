/**
 * Created by Dmitry Bobylev on 05.09.2019.
 */

public with sharing class PaginationData {
    @AuraEnabled public Integer allRecordsCount;
    @AuraEnabled public Integer pagesCount;
    @AuraEnabled public Integer currentPageCount;
    @AuraEnabled public Integer pageRecordsCount;
    @AuraEnabled public Integer currentPage;
    @AuraEnabled public Integer offset;
    @AuraEnabled public Integer endOffset;

    public PaginationData(){
        currentPage = 1;
        pageRecordsCount = 5;
    }

    public void setRecordsCount(Integer allRecordsCount){
        this.allRecordsCount = allRecordsCount;
        recalc();
    }

    public void recalc(){
        Decimal allRecordsCountDecimal = allRecordsCount;
        Decimal pageRecordsCountDecimal = pageRecordsCount;
        Decimal allPagesDecimal = allRecordsCountDecimal/pageRecordsCountDecimal;
        pagesCount = allPagesDecimal.intValue();
        allPagesDecimal = allPagesDecimal.round(System.RoundingMode.UP);
        if(currentPage > allPagesDecimal) currentPage = allRecordsCount == 0 ? 1 : pagesCount;

        offset = (currentPage - 1) * pageRecordsCount;
        endOffset = offset + pageRecordsCount;
        if(endOffset > allRecordsCount) endOffset = allRecordsCount;

        currentPageCount = endOffset - offset;
    }
}