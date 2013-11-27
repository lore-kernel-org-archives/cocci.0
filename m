From: mstefani@redhat.com (Michael Stefaniuc)
Date: Wed, 27 Nov 2013 23:26:29 +0100
Subject: [Cocci] Incorrect skipping on custom types in type list
Message-ID: <52967195.9040505@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

@@
typedef VOID;
typedef LPVOID;
typedef PVOID;
{void *, VOID *, LPVOID, PVOID} ppv;
identifier QI =~ "_QueryInterface$";
@@
* QI(..., ppv)

executed on

int IFoo_QueryInterface(int *iface, long *riid, void **ppv)
{
    return IBar_QueryInterface(iface, riid, *ppv);
}

gives:
$ spatch QI.cocci /tmp/qi.c
HANDLING: /tmp/qi.c
No matches found for PVOID
Skipping:/tmp/qi.c

Putting LPVOID or VOID* last in the type list gives:
No matches found for LPVOID
respectively
No matches found for VOID

With void* in there I wouldn't have expected it to skip any files at all.

bye
	michael
