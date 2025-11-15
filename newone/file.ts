const func = () => {
    console.log('the result')
}

func()

const smellygirl = 'Anugraha'

console.log(smellygirl)

type NextFuntion = Function


class SmellyGirl {
    constructor(){}

    anugraha() {
        console.log('oo pinne')
    }
    thalakVayya() {
        console.log('pink color churithar')
    }
}

const AsyncHandler = (fn: (req: Request, res: Response, next: NextFuntion) => Promise<void>) => 
        async (req: Request, res: Response, next: NextFuntion) => Promise.resolve(fn(req, res, next)).catch(next)


const AsyncHandlerAwait = (fn: (req: Request, res: Response, next: NextFuntion) => Promise<void>) => 
        async (req: Request, res: Response, next: NextFuntion) => {
            try {
                await fn(req, res, next)
            } catch (err) {
                next(err)
            }
        }