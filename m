From: eliseomarmol@gmail.com (=?windows-1252?Q?Eliseo_Mart=EDnez?=)
Date: Thu, 22 Jan 2015 10:23:06 +0100
Subject: [Cocci] Matching functions with attributes
In-Reply-To: <54C0BBF9.3040804@users.sourceforge.net>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
 <54BFD099.8030002@users.sourceforge.net>
 <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
 <alpine.DEB.2.10.1501212342170.2599@hadrien>
 <02347CD6-6A31-41A9-B4EE-58163C49368C@gmail.com>
 <54C0BBF9.3040804@users.sourceforge.net>
Message-ID: <606B3094-FA8F-4BC7-BDE2-FC0974EAE640@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Can you give an example of some code in which you find a match?

Here they are some examples of code matched by

```
@@ identifier func =~ "^(vim_strsave|list_alloc)$"; identifier var; statement S; expression E; @@

 var = func(...);
 ... when != var = E
(
* if (var == NULL)
   S
|
* if (var != NULL)
   S
)
```

but missed if we put S in the same line as ?if?.

```
      p = home_replace_save(NULL, files[i]);
*     if (p != NULL) {
        free(files[i]);
        files[i] = p;
      }
```

```
    p = vim_strsave(p);
    rettv->vval.v_string = p;
*   if (p != NULL)
      shorten_dir(p);
```

```
  if (temp_result != NULL && nextcmd == NULL) {
    retval = xmalloc(STRLEN(temp_result) + (expr_start - in_start)
                     + (in_end - expr_end) + 1);
    STRCPY(retval, in_start);
    STRCAT(retval, temp_result);
    STRCAT(retval, expr_end + 1);
  }
  free(temp_result);

  *in_end = c1;                 /* put char back for error messages */
  *expr_start = '{';
  *expr_end = '}';

* if (retval != NULL) {
    temp_result = find_name_end(retval, &expr_start, &expr_end, 0);
    if (expr_start != NULL) {
      /* Further expansion! */
      temp_result = make_expanded_name(retval, expr_start,
          expr_end, temp_result);
      free(retval);
      retval = temp_result;
    }
  }

```

This last case is a false positive, as retval can be null if we don?t enter the ?if? where it?s assigned. But it conforms to the specified spatch, so I add it as an example of more complex code matched by it.
So, when S is in a separated line, everything seems to work perfectly. I have 63 matches for that in my code.
If I put S in the same line as ?if?, then it finds 0 matches.
