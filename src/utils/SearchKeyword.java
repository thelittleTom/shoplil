package utils;

import java.util.Arrays;
import java.util.List;

public class SearchKeyword{
    public static boolean isContenKeyword(String keywords,String txt){
        String []listKeywords= keywords.split("\\s+");
        for(int i=0;i<listKeywords.length;i++){
            String keyword=listKeywords[i];
            if(txt.contains(keywords)){
                return true;
            }
        }
        return false;
    }
}
