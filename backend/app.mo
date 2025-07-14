import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Array "mo:base/Array";

actor {

  // Tipo que representa un comprobante firmado
  type Comprobante = {
    hash : Text;
    firma : Text;
    fecha : Text; // opcional, podés usar Timestamp también
  };

  // Mapeo de documento (DNI o similar) → lista de comprobantes
  let comprobantesPorDoc = HashMap.HashMap<Text, [Comprobante]>(10, Text.equal, Text.hash);

  // Agregar un nuevo comprobante a un documento
  public func agregarComprobante(docId : Text, hash : Text, firma : Text, fecha : Text) : async () {
    let nuevo = { hash = hash; firma = firma; fecha = fecha };
    let anteriores = switch (comprobantesPorDoc.get(docId)) {
      case (null) [];
      case (?lista) lista;
    };
    comprobantesPorDoc.put(docId, Array.append(anteriores, [nuevo]));
  };

  // Obtener todos los comprobantes de un documento
  public query func obtenerComprobantes(docId : Text) : async [Comprobante] {
    switch (comprobantesPorDoc.get(docId)) {
      case (null) [];
      case (?lista) lista;
    }
  };

};

