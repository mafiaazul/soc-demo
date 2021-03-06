public with sharing class GithubUserService {
  public static List<Id> createGithubUsers(Set<String> userIds){
    try{
      List<JSONParser.UserProfile> userProfiles = new List<JSONParser.UserProfile>();

      for(String userId : userIds){
        //Github REST API is not bulkified, be careful and do not flood their interface here;
        String remoteServiceResponse = RemoteService.getUserData(userId);
        userProfiles.add(JSONParser.parseUserData(remoteServiceResponse));
      }

      return GithubUsers.createRecords(userProfiles);
    }catch (Exception e){
      throw new GithubUserServiceException(e.getMessage());
    }
  }

  public class GithubUserServiceException extends Exception {}
}
