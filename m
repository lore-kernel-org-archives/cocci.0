From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 16 Jan 2017 07:31:08 +0100 (CET)
Subject: [Cocci] rework a function to move parameters around ....
In-Reply-To: <CAP6exY+oh2PAxaYvSHbkXTBAfLPpTsb4tXXPG-5TRQQ54Nw1Ag@mail.gmail.com>
References: <CAP6exYJV8O6siwkwin4B+_R=PSOR9HthOfGe0DJsqXaPrN44yg@mail.gmail.com>
 <alpine.DEB.2.20.1701160718350.1947@hadrien>
 <CAP6exY+oh2PAxaYvSHbkXTBAfLPpTsb4tXXPG-5TRQQ54Nw1Ag@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701160730430.1947@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This is not tested.

---

// both field initializations after the original call

@@
struct lb_header *header;
expression e1,e2,e3,sz,ty,serial;
@@

- serial = (struct lb_serial *)lb_new_record(header);
... when != serial = e1
- serial->size = sz;
... when != serial = e2
    when != serial->size = e3
- serial->type = ty;
+ serial = (struct lb_serial *)lb_new_record(header, sz, ty);

@@
struct lb_header *header;
expression e1,e2,e3,sz,ty,serial;
@@

- serial = (struct lb_serial *)lb_new_record(header);
... when != serial = e1
- serial->type = ty;
... when != serial = e2
    when != serial->type = e3
- serial->size = sz;
+ serial = (struct lb_serial *)lb_new_record(header, sz, ty);

// both field initializations before the original call

@@
struct lb_header *header;
expression e1,e2,e3,e4,e5,sz,ty,serial;
@@

- serial->type = ty;
... when != serial = e1
    when != serial->type = e2
- serial->size = sz;
... when != serial = e3
    when != serial->type = e4
    when != serial->size = e5
  serial = (struct lb_serial *)lb_new_record(header
+ , sz, ty
  );

@@
struct lb_header *header;
expression e1,e2,e3,e4,e5,sz,ty,serial;
@@

- serial->size = sz;
... when != serial = e1
    when != serial->size = e2
- serial->type = ty;
... when != serial = e3
    when != serial->size = e4
    when != serial->type = e5
  serial = (struct lb_serial *)lb_new_record(header
+ , sz, ty
  );

// field initializations around the original call

@@
struct lb_header *header;
expression e1,e2,e3,e4,sz,ty,serial;
@@

- serial->size = sz;
... when != serial = e1
    when != serial->size = e2
- serial = (struct lb_serial *)lb_new_record(header);
... when != serial = e3
    when != serial->size = e4
- serial->type = ty;
+ serial = (struct lb_serial *)lb_new_record(header, sz, ty);


@@
struct lb_header *header;
expression e1,e2,e3,e4,sz,ty,serial;
@@

- serial->type = ty;
... when != serial = e1
    when != serial->type = e2
- serial = (struct lb_serial *)lb_new_record(header);
... when != serial = e3
    when != serial->type = e4
- serial->size = sz;
+ serial = (struct lb_serial *)lb_new_record(header, sz, ty);
