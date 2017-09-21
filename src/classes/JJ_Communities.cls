public class JJ_Communities {
	 @AuraEnabled
    public static String getCommunitiesInfo1() {
        
        JSONGenerator gen = JSON.createGenerator(true);
		gen.writeStartObject();
        gen.writeObjectField('objectBranding', getBranding());
        gen.writeStringField('getNetworkId', Network.getNetworkId());
        gen.writeStringField('getLoginUrl', Network.getLoginUrl(Network.getNetworkId()));
        //gen.writeObjectField('getLogoutUrl', ApexPages.currentPage().getParameters().getUrl());
        gen.writeObjectField('getBaseRequestUrl', Site.getBaseRequestUrl());
        gen.writeObjectField('getBaseCustomUrl', Site.getBaseCustomUrl());
        gen.writeObjectField('getBaseInsecureUrl', Site.getBaseInsecureUrl());
        gen.writeObjectField('getBaseSecureUrl', Site.getBaseSecureUrl());
        gen.writeObjectField('getBaseUrl', Site.getBaseUrl());
        //gen.writeObjectField('getDomain', Site.getDomain());
        gen.writeObjectField('getNameApi', Site.getName());
        //gen.writeObjectField('getOriginalUrl', Site.getOriginalUrl());
        gen.writeObjectField('getPathPrefix', Site.getPathPrefix());
        gen.writeObjectField('getSiteId', Site.getSiteId());
              
        gen.writeEndObject();
        //String pretty = gen.getAsString();

        ////select id, AssetCategory, CustomBrandId, TextAsset from CustomBrandAsset
    
        return pretty;
    } 
    
    public static Map<String,String> getBranding() {
        Map<String,String> branding =  new Map<String,String>();
        Id communityId = Network.getNetworkId();
        List<CustomBrand> CustomBrandId = [ select id from CustomBrand where ParentId =: communityId Limit 1];
        for(CustomBrandAsset asset : [select id, AssetCategory, CustomBrandId, TextAsset from CustomBrandAsset where CustomBrandId =: CustomBrandId[0].Id]) {
            branding.put(asset.AssetCategory,asset.TextAsset);
        }
        return branding;
    }
}