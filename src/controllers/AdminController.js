const { render } = require("express/lib/response");

function CRUDplantas(req, res){
        res.render('admin/CRUDplantas',{ name: req.session.name, admin: req.session.admin });

}

function createPlants(req, res) {
    const data = req.body;

    req.getConnection(async (err, conn) => {
        if (err) {
            // Manejar errores de conexión a la base de datos
            console.error('Error de conexión a la base de datos:', err);
            return res.status(500).send('Error interno del servidor');
        }

        const checkPlantQuery = 'SELECT * FROM Cultivo WHERE Nombre_Genero = ? AND Nombre_Especie = ?';

        try {
            const [plantData] = await conn.promise().query(checkPlantQuery, [data.genero, data.especie]);

            if (plantData.length > 0) {
                // El registro ya existe
                return res.render('admin/CRUDplantas', { error: 'Error: Registro ya existente!' , name: req.session.name, admin: req.session.admin });
            }

            // Registro no existe, proceder con la inserción
            // Iniciar la transacción
            await conn.promise().beginTransaction();

            try {
                // Insertar datos en la tabla Catalogo_Taxonomia_C
                const [resultado1] = await conn.promise().query('INSERT INTO Catalogo_Taxonomia_C (Reino, Filo, Clase, Orden, Familia, Genero, Especie) VALUES (?, ?, ?, ?, ?, ?, ?)',
                    [data.reino, data.filo, data.clase, data.orden, data.familia, data.genero, data.especie]);

                const idCatalogoTaxonomia = resultado1.insertId;

                // Insertar datos en la tabla Cultivo
                await conn.promise().query('INSERT INTO Cultivo (Tipo, RegionGeografica, Foto, Nombre_Comun, Nombre_Especie, Nombre_Genero, Rasgos_Especificos, Informacion_Cuidado, Catalogo_Taxonomia_idCatalogo_Taxonomia) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
                    [data.tipo, data.regionGeografica, data.foto, data.nombreComun, data.especie, data.genero, data.rasgosEspecificos, data.informacionCuidado, idCatalogoTaxonomia]);

                // Hacer commit para aplicar los cambios
                await conn.promise().commit();

                console.log('Datos insertados correctamente.');
            } catch (error) {
                // Si hay un error, hacer rollback para deshacer los cambios
                await conn.promise().rollback();
                console.error('Error:', error);
                res.status(500).send('Error al insertar datos');
            } 

            // Redirigir después de que la operación se haya completado correctamente
            return res.render('admin/CRUDplantas', { name: req.session.name, admin: req.session.admin });

        } catch (err) {
            // Manejar errores de consulta a la base de datos
            console.error('Error: ', err);
            res.status(500).send('Error interno del servidor');
        }
    });
}

function readPlants(req, res){
    req.getConnection((err, conn) =>{
        if (err) {
            // Manejar errores de conexión a la base de datos
            console.error('Error de conexión a la base de datos:', err);
            return res.status(500).send('Error interno del servidor');
        }

        const readPlantQuery = 'SELECT idCultivo, Nombre_Comun, Nombre_Genero, Nombre_Especie, Tipo, RegionGeografica, Catalogo_Taxonomia_idCatalogo_Taxonomia FROM Cultivo';

        try{

            conn.query(readPlantQuery, (err, results) =>{
                if (err) {
                    // Manejar errores de consulta a la base de datos
                    console.error('Error en la consulta a la base de datos:', err);
                    return res.status(500).send('Error interno del servidor');
                }
                res.json(results);
            })

        } catch(error){

        }

    });  
}

function redirectUpdatePlant (req, res){

    res.render('admin/UpdatePlantas',{ name: req.session.name, admin: req.session.admin });
    
}


module.exports = {
    CRUDplantas,
    createPlants, 
    readPlants,
    redirectUpdatePlant,  
}