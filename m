From: jmiguel.hdez@gmail.com (jmiguel hernandez)
Date: Thu, 2 Oct 2014 15:12:00 -0500
Subject: [Cocci] How can i rename a specific structure field?
Message-ID: <CAHsAT8KbZS0xb4DpdL9oSKWRCJJ4gm0DWaiHi_+KvsqnFGaBNQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

if i have this

typedef struct type1 {
  char8 a;
  char8 b;
  char8 c;
}

typedef struct _interface {
  type1 field1;
}interface;

and want to change to

typedef struct type1 {
  char8 d;
  char8 b;
  char8 c;
}

typedef struct _protocol {
  type1 *field1;
}interface;

interface *p

-p->field->a
+p->field->d

I have tried just changing field1 to field2. This gives parsing errors.

@@
typedef interface;
interface *p;
typedef type1;
type1 field1;
@@
<...
-p->field1
+p->fieldnew
...>

also, similar question. What if i want to change the type.

typedef struct _interface {
  type2 *field1;
}interface;

Thanks
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141002/89ff092a/attachment.html>
