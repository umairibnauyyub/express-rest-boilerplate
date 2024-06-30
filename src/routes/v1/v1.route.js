import express from 'express'
import authRoutes from '#routes/v1/auth'
import userRoutes from '#routes/v1/user'

const router = express.Router()

router.use('/users', userRoutes)
router.use('/auth', authRoutes)

export default router
