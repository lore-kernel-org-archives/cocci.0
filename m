From: chrubis@suse.cz (Cyril Hrubis)
Date: Mon, 6 Oct 2014 12:25:00 +0200
Subject: [Cocci] string parameter concatenation
In-Reply-To: <alpine.DEB.2.02.1410021858360.2062@localhost6.localdomain6>
References: <20141001130215.GB4701@rei.suse.cz>
 <alpine.DEB.2.02.1410021858360.2062@localhost6.localdomain6>
Message-ID: <20141006102500.GC8551@rei.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!
> > I've found a small nit in the handling of strings that spans over
> > multiple lines:
> > 
> > nit.c:
> > int main(void)
> > {
> >         f("This is a string that continues to the next line"
> >           " just string continuation");
> > }
> 
> The patch below solves this problem as well as the one with the long 
> string in the argument list.

It's better but it produces changes like this:

@@ -250,9 +250,14 @@ void l_seek(int fdesc, off_t offset, int whence, off_t checkoff)
        off_t offloc;
 
        if ((offloc = lseek(fdesc, offset, whence)) != checkoff) {
-               tst_resm(TFAIL, "(%ld = lseek(%d, %ld, %d)) != %ld) errno = %d",
-                        offloc, fdesc, offset, whence, checkoff, errno);
-               tst_exit();
+               tst_brkm(TFAIL, NULL,
+                        "(%ld = lseek(%d, %ld, %d)) != %ld) errno = %d",
+                        offloc,
+                        fdesc,
+                        offset,
+                        whence,
+                        checkoff,
+                        errno);
        }
 }

Which seems to be waste of vertical space to me.

-- 
Cyril Hrubis
chrubis at suse.cz
