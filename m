From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 22 Jan 2015 13:52:12 +0200 (SAST)
Subject: [Cocci] Matching functions with attributes
In-Reply-To: <606B3094-FA8F-4BC7-BDE2-FC0974EAE640@gmail.com>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
 <54BFD099.8030002@users.sourceforge.net>
 <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
 <alpine.DEB.2.10.1501212342170.2599@hadrien>
 <02347CD6-6A31-41A9-B4EE-58163C49368C@gmail.com>
 <54C0BBF9.3040804@users.sourceforge.net>
 <606B3094-FA8F-4BC7-BDE2-FC0974EAE640@gmail.com>
Message-ID: <alpine.DEB.2.10.1501221350370.4079@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

With the following source code:

int main() {
     p = home_replace(NULL, files[i]);
      if (p != NULL) {
        free(files[i]);
        files[i] = p;
      }
}

and the following semanticpatch:

@@ identifier func =~ "^(vim_strsave|list_alloc)$"; identifier var;
statement S; expression E; @@

  var = func(...);
  ... when != var = E
* if (var != NULL)
    S

I get nothing.  If I remove the regular expression, then I get results
with the above semantic patch and with the following semantic partch:

@@ identifier func =~ "^(vim_strsave|list_alloc)$"; identifier var;
statement S; expression E; @@

  var = func(...);
  ... when != var = E
* if (var != NULL)    S

Probably the issue inmy case is the kind of regular expression being used.
Are you using pcre?

julia
