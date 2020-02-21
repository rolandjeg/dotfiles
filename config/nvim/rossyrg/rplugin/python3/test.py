class myDecorator(object):
    def __init__(self):
        print("inside myDecorator.__init__")

    def __call__(self):
        print("inside __call__")


#@myDecorator
def aFunction():
    print("test")

aFunction()
myDecorator()
