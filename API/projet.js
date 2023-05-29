function projet(app,helpers){
    app.get('/projet', (req,res) => {
        helpers.returnAll('projet',req,res)
    })

    app.get('/projet/:id', (req,res) => {
        const id = parseInt(req.params.id)
        helpers.getProjetByUserId(id,req,res)
    })

    app.get('/projet/participation/:id', (req,res) => {
        const id = parseInt(req.params.id)
        helpers.getProjetParticipationByUserId(id,req,res)
    })

    app.get('/projet/member/:id', (req,res) => {
        const id = parseInt(req.params.id)
        helpers.getAllMemberByProjetId(id,req,res)
    })

    app.get('/projet/:id/remove/:idmember', (req,res) => {
        const idprojet = parseInt(req.params.id)
        const idmember = parseInt(req.params.idmember)
        helpers.removeMemberFromProjet(idprojet,idmember,req,res)
    })

    app.post('/projet', (req,res) => {
        nom = req.body.nom
        id = parseInt(req.body.id)
        helpers.addOneProjet(nom,id)
        helpers.returnAll('projet',req,res)
    })

    app.post('/projet/addMember', (req,res) => {
        username = req.body.username
        id = parseInt(req.body.id)
        helpers.addMember(username,id)
        helpers.returnAll('projet',req,res)
    })

    app.get('/projet/:id/delete', (req,res) => {
        const id = parseInt(req.params.id)
        helpers.deleteOneByTableAndId('livre',id)
    })

    app.post('/tache', (req,res) => {
        nom = req.body.nom
        deadline = req.body.deadline
        idprojet = parseInt(req.body.idprojet)
        helpers.addOneTache(idprojet, nom, deadline)
        helpers.returnAll('tache',req,res)
    })

    app.get('/tache/:id/delete', (req,res) => {
        const id = parseInt(req.params.id)
        helpers.deleteOneByTableAndId('page',id)
    })

    
    app.get('/projet/:id/getTache', (req,res) => {
        const idprojet = parseInt(req.params.id)
        helpers.getTache(idprojet, req,res)
    })

    app.get('/tache/:id/updateTache', (req,res) => {
        const idprojet = parseInt(req.params.id)
        helpers.updateTache(idprojet, req,res)
    })
}

module.exports = {
    projet
};