From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Thu, 2 Oct 2014 22:47:18 +0200
Subject: [Cocci] minor issue: pretty printing for modified functions
	as	arguments
In-Reply-To: <alpine.DEB.2.02.1410020835420.2068@localhost6.localdomain6>
References: <20141001184054.GM14081@wotan.suse.de>
 <alpine.DEB.2.02.1410020835420.2068@localhost6.localdomain6>
Message-ID: <20141002204718.GS14081@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Oct 02, 2014 at 08:39:05AM +0200, Julia Lawall wrote:
> Is the problem that eg you get (indentation removed for readability):
> 
> -int (*unknown)(char *param, char *val, const char *doing))
> +void *arg,int (*unknown)(char *param, char *val, const char *doing, void *arg))
> 
> instead of
> 
> -int (*unknown)(char *param, char *val, const char *doing))     
> +void *arg,                                                     
> +int (*unknown)(char *param, char *val,                         
> +               const char *doing, void *arg))

Yes, and if you look closely there is no reason to remove the unknown
line completely just to add it back, we really ideally only wish to
express on the final patch the addition of the void *arg as a third
argument to the callback, so this is what we should see on the patch
instead:


--- a/include/linux/moduleparam.h                                               
+++ b/include/linux/moduleparam.h                                               
@@ -327,8 +327,9 @@ extern char *parse_args(const char *name,                   
                      unsigned num,                                             
                      s16 level_min,                                            
                      s16 level_max,                                            
+                     void *arg,                                                
                      int (*unknown)(char *param, char *val,                    
-                             const char *doing));                              
+                                    const char *doing, void *arg));  


So two things, one is the new void *arg passed to parse_args() and
the other is the addition of a third arguemtn to the callback.
In terms of style I think we can live with having the new arguments aligned
to where the first argument on the callback starts (tabs first and spaces
only if a tab does not fit).

This applies to the header file as well as on to the C file. Coccinelle
gives:

--- a/kernel/params.c                                                           
+++ b/kernel/params.c                                                           
@@ -183,7 +183,7 @@ char *parse_args(const char *doing,                         
                 unsigned num,                                                  
                 s16 min_level,                                                 
                 s16 max_level,                                                 
-                int (*unknown)(char *param, char *val, const char *doing))     
+                void *arg,int (*unknown)(char *param, char *val, const char *doing, void *arg))
 {                                                                              
        char *param, *val;                                                      
        

While we want:


diff --git a/kernel/params.c b/kernel/params.c                                  
index 34f5270..4182607 100644                                                   
--- a/kernel/params.c                                                           
+++ b/kernel/params.c                                                           
@@ -90,8 +90,9 @@ static int parse_one(char *param,                             
                     unsigned num_params,                                       
                     s16 min_level,                                             
                     s16 max_level,                                             
+                    void *arg,                                                 
                     int (*handle_unknown)(char *param, char *val,              
-                                    const char *doing))                        
+                                    const char *doing, void *arg))             
 {                                                                              
        unsigned int i;                                                         
        int err;    

> I think that the problem is that Coccinelle does not try to respect 80
> columns when there are nested parentheses.  But it seems like it could be
> possible to at least have the declaration of unknown moved to the next
> line.

Great!

  Luis
